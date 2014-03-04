From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
Date: Tue, 04 Mar 2014 07:46:55 +0100
Subject: [PATCH] CNS3xxx: Fix PCIe early iotable_init().
In-Reply-To: <7246660.Cp8cQBZRIp@wuerfel> (Arnd Bergmann's message of "Fri, 28
 Feb 2014 12:15:54 +0100")
References: <m3eh2nqz7n.fsf@t19.piap.pl> <m3sir3pk2a.fsf@t19.piap.pl>
 <7246660.Cp8cQBZRIp@wuerfel>
Message-ID: <m3zjl6o3z4.fsf@t19.piap.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> Patch looks good, but please add the changeset description from
> your first patch.

I wonder if another approach would be better. I don't like the .pfn
messing and the bugs that function introduces.
-- 
Krzysztof Halasa

Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland
