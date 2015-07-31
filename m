From: rsahu@apm.com (Rameshwar Sahu)
Date: Fri, 31 Jul 2015 14:42:23 +0530
Subject: [PATCH v1 3/4] Crypto: Add support for APM X-Gene SoC CRC32C h/w
 accelerator driver
In-Reply-To: <20150731071358.GA25228@gondor.apana.org.au>
References: <1438258268-3099-1-git-send-email-rsahu@apm.com>
 <1438258268-3099-4-git-send-email-rsahu@apm.com>
 <20150731071358.GA25228@gondor.apana.org.au>
Message-ID: <CAFd313xLojXUrAyY5xCFa_rTFzJn9=N=OUsRhBg+iDv25uSh6A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 31, 2015 at 12:43 PM, Herbert Xu
<herbert@gondor.apana.org.au> wrote:
> On Thu, Jul 30, 2015 at 05:41:07PM +0530, Rameshwar Prasad Sahu wrote:
>>
>> +             .cra_name               = "xgene(crc32c)",
>> +             .cra_driver_name        = "crc32c-xgene",
>
> This looks wrong.  If you're implementing crc32c then cra_name
> should be just crc32c, i.e., the name of the algorithm that you
> are providing.

Okay, I will change it to crc32c only.
>
>> +MODULE_DESCRIPTION("APM X-Gene SoC CRC32C HW accelerator driver");
>> +MODULE_AUTHOR("Rameshwar Prasad Sahu <rsahu@apm.com>");
>> +MODULE_LICENSE("GPL");
>> +MODULE_VERSION("1.0");
>
> You should add a MODULE_ALIAS_CRYPTO too.
Okay
>
> Cheers,
> --
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
> --
> To unsubscribe from this list: send the line "unsubscribe dmaengine" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
