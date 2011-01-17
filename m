From: eric@eukrea.com (=?ISO-8859-1?Q?Eric_B=E9nard?=)
Date: Mon, 17 Jan 2011 10:02:26 +0100
Subject: [RFC 2/2] AT91: Update board-cpu9krea to support the 9260/9G20
	variants in a single image
In-Reply-To: <20110117075002.GH14798@game.jcrosoft.org>
References: <1295113835-6776-1-git-send-email-albin.tonnerre@free-electrons.com>
	<1295113835-6776-2-git-send-email-albin.tonnerre@free-electrons.com>
	<20110117075002.GH14798@game.jcrosoft.org>
Message-ID: <4D3405A2.70401@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jean-Christophe,

On 17/01/2011 08:50, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 18:50 Sat 15 Jan     , Albin Tonnerre wrote:
>> Since patch "Support SAM9260 and SAM9G20-based boards in the same kernel
>> image" makes it possible to support both types of SoCs, cpu9krea must be
>> updated to cope with that. Otherwise, selecting both the 9260 and 9G20
>> variants will result in only the 9260 variant being supported.
>>
>> Signed-off-by: Albin Tonnerre<albin.tonnerre@free-electrons.com>
>> ---
> do you really need 2 machine id?
>
this was needed when 9260 & 9G20 were not merged.
Please if you change our platform files keep the 2 machine ID else that will 
break upgrade path on existing machines.

Thanks,
Eric
