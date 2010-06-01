From: davem@davemloft.net (David Miller)
Date: Tue, 01 Jun 2010 00:18:55 -0700 (PDT)
Subject: [PATCH] ixp4xx: Support the all multicast flag on the NPE devices.
In-Reply-To: <m3typoyr86.fsf@intrepid.localdomain>
References: <m3pr0c17ue.fsf@intrepid.localdomain>
	<20100531153419.GA17317@riccoc20.at.omicron.at>
	<m3typoyr86.fsf@intrepid.localdomain>
Message-ID: <20100601.001855.71558565.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Mon, 31 May 2010 18:24:09 +0200

> Richard Cochran <richardcochran@gmail.com> writes:
> 
>> This patch adds support for the IFF_ALLMULTI flag. Previously only the
>> IFF_PROMISC flag was supported.
>>
>> Signed-off-by: Richard Cochran <richard.cochran@omicron.at>
 ...
> Acked-By: Krzysztof Halasa <khc@pm.waw.pl>

Applied.
