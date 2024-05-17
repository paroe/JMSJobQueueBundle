<?php

namespace JMS\JobQueueBundle\Entity\Type;

use Doctrine\DBAL\Platforms\AbstractPlatform;
use Doctrine\DBAL\Types\ConversionException;
use Doctrine\DBAL\Types\JsonType;

class SafeObjectType extends JsonType
{
    public function getSQLDeclaration(array $fieldDeclaration, \Doctrine\DBAL\Platforms\AbstractPlatform $platform): string
    {
        return $platform->getBlobTypeDeclarationSQL($fieldDeclaration);
    }

    public function convertToDatabaseValue($value, AbstractPlatform $platform)
    {
        // temporarily do not save anything to the db
        return null;
    }

    public function convertToPHPValue($value, AbstractPlatform $platform)
    {
        // temporarily disable parsing of data from db
        return null;
    }

    public function getName(): string
    {
        return 'jms_job_safe_object';
    }
}
