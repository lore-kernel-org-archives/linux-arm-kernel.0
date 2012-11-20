From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Tue, 20 Nov 2012 15:22:03 +0400
Subject: [PATCH 3/3] net: mvneta: adjust multiline comments to net/ style
In-Reply-To: <20121119135609.3808b1c7@skate>
References: <1353322834-16952-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1353322834-16952-4-git-send-email-thomas.petazzoni@free-electrons.com>
 <50AA2AD4.6030007@mvista.com> <20121119135609.3808b1c7@skate>
Message-ID: <50AB67DB.3030309@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 19-11-2012 16:56, Thomas Petazzoni wrote:

>>> -/*
>>> - * The two bytes Marvell header. Either contains a special value used
>>> +/* The two bytes Marvell header. Either contains a special value used
>>
>>      Why the heck you're doing this? It's the preferred style, see
>> Documentation/CodingStyle, chapter 8.

> No. Please read Documentation/CodingStyle, chapter 8 entirely:

> ===============================================================
> The preferred style for long (multi-line) comments is:
>
>          /*
>           * This is the preferred style for multi-line
>           * comments in the Linux kernel source code.
>           * Please use it consistently.
>           *
>           * Description:  A column of asterisks on the left side,
>           * with beginning and ending almost-blank lines.
>           */
>
> For files in net/ and drivers/net/ the preferred style for long
> (multi-line) comments is a little different.
>
>          /* The preferred comment style for files in net/ and drivers/net
>           * looks like this.
>           *
>           * It is nearly the same as the generally preferred comment style,
>           * but there is no initial almost-blank line.
>           */
> ===============================================================

> Seen the second part?

    Not until now probably. Sorry for the noise then. :-/

WBR, Sergei
