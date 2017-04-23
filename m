From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sun, 23 Apr 2017 12:38:42 +0200
Subject: s3c24xx: Use devm_kcalloc() in s3c24xx_dma_probe()
In-Reply-To: <f1257887-ca14-6415-b1ff-d57190a1810f@math.uni-bielefeld.de>
References: <930f0a6c-bc5c-3d01-6814-563780fc90ef@users.sourceforge.net>
 <9c10b823-f49b-8c73-2bf8-0fd2b0ba0231@users.sourceforge.net>
 <f1257887-ca14-6415-b1ff-d57190a1810f@math.uni-bielefeld.de>
Message-ID: <02134825-fec7-73d7-2eb6-b510eaaf3b08@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> * A multiplication for the size determination of a memory allocation
>>   indicated that an array data structure should be processed.
>>   Thus use the corresponding function "devm_kcalloc".
> I have trouble parsing that sentences. This looks like the typical
> approach of native german speakers to directly transfer sentence
> constructions from German to English. Which, in most cases, doesn't work
> or is just plain confusing.

Do you find the following wording better to understand
if it would be presented by a script like ?checkpatch.pl??

WARNING: Prefer devm_kcalloc over devm_kzalloc with multiply


Regards,
Markus
