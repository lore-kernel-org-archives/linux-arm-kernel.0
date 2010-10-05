From: eric@eukrea.com (=?ISO-8859-1?Q?Eric_B=E9nard?=)
Date: Tue, 05 Oct 2010 17:50:39 +0200
Subject: [PATCH] ulpi: add i.MX25 & 35 internal PHY ID
In-Reply-To: <4CAB477B.5010003@compulab.co.il>
References: <1286195012-18999-1-git-send-email-eric@eukrea.com>
	<4CA9EAA0.2060608@ru.mvista.com> <4CA9EF97.5040908@compulab.co.il>
	<20101005054225.GK7159@buzzloop.caiaq.de>
	<4CAB2145.8050605@compulab.co.il> <4CAB4047.1090401@eukrea.com>
	<4CAB477B.5010003@compulab.co.il>
Message-ID: <4CAB494F.2060704@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Igor,

Le 05/10/2010 17:42, Igor Grinberg a ?crit :
>> In fact, that's my fault, the internal PHY is not ULPI but UTMI so we should not use these functions here and it was working until now by chance as there are dedicated registers to control the internal PHY which are initialized with the right values as a default.
>
> Too bad... I hope, I was useful in your discovery...
>
yes as your patch would have worked if this was really an ULPI PHY ;-)
>>
>> Sorry for the noise and forget my patch which is wrong, I'll rework the platform data as in the present case we should not provide use ulpi when using the internal PHY.
>
> OK.
> Nevertheless, I want to resend a version of my patch properly.
> It proves useful after all...
> Any comments/suggestions will be appreciated.
>
I'll test it asap on other platforms really having ULPI.

Thanks
Eric
