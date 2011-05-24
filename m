From: grinberg@compulab.co.il (Igor Grinberg)
Date: Tue, 24 May 2011 09:19:37 +0300
Subject: Initial B&N Nook Color support, take four
In-Reply-To: <1306098276-21112-1-git-send-email-green@linuxhacker.ru>
References: <1306098276-21112-1-git-send-email-green@linuxhacker.ru>
Message-ID: <4DDB4DF9.3070703@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/23/11 00:04, green at linuxhacker.ru wrote:
> Hello!
>
>   Next attempt at B&N Nook Color board file submission.
>   USB peripheral mode is fully operational as is serial console and
>   MMC/SDCard.
>
>   Changes
>   since v3:
>   Separated mach-types change into a separate patch (already got RMK approval)
>   Dramatically cut number of includes in the board file again.
>   No longer set voltage regulator dev, just device name in the supply.
>   Style fixes
>   Serial in uncompress.h sorted by name
>   Corrected MUX package to CBP in board file.
>   omap_i2c_init now has no return since it's unused anyway.
>   Fixed keypad definition.
>
>   since v2:
>   rebased on devel-cleanup branch
>
>   since v1:
>   Threw away all the android stuff as suggested 
>   Cleaned up voltage regulators and removed the ones our twl chip actually
>     does not have
>   Changed the split of the patches to board file + twl update
>
> Bye,
>    Oleg

Good cover letter, though keep in mind that making it long long, can hit people laziness ;)


-- 
Regards,
Igor.
