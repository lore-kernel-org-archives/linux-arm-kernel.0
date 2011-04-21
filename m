From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 21 Apr 2011 12:56:07 +0100
Subject: [PATCH 1/3] Framework for exporting System-on-Chip information
	via sysfs
In-Reply-To: <201104211303.04043.arnd@arndb.de>
References: <1302792592-17484-1-git-send-email-lee.jones@linaro.org>
	<201104172036.45052.arnd@arndb.de> <4DAFFC6B.80708@linaro.org>
	<201104211303.04043.arnd@arndb.de>
Message-ID: <4DB01B57.9090909@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

</snip>

>>> (I believe this would be Copyright Linaro Ltd, not ST-Ericsson SA,
>>> but better ask internally in ST-Ericsson about what your rules are)
>>
>> We've had internal discussions about this. I believe this is the correct
>> thing to do. The Copyright should stay with ST-Ericsson.
> 
> Ok, in that case, I'd suggest you use your ST-Ericsson address for
> Signed-off-by and the author statement above.

I'm not an ST-Ericsson employee, thus do not have an associated address.

I work for Linaro, currently on assignment to ST-Ericsson.

</snip>

> I would prefer to standardise the attributes as much as possible. Ideally,
> all SOCs should export the same set of attributes, and in no case should
> there be multiple SOCs that have the same attribute name but with a
> slightly different interface (e.g. one writable, or one root-only readable),
> or the same contents in attributes of different names.
> 
> The best way to ensure this is to give less flexiblity to the person
> implementing the individual SOC code. All attributes that are documented
> to be available across SOCs can simply be automatically created and
> filled with the data provided by the platform.
> 
> Having interfaces specific to one SOC should be the absolute exception,
> so I'd try to make that as hard as possible.

Well your word overrides mine.

I'll completely rewrite the driver again. It may be some time before
it's complete (post-UDS/LDS), as I have a lot on 'till then. I would
like to see this to the end though, so leave it with me.

Kind regards,
Lee
