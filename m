From: christophe.jaillet@wanadoo.fr (Christophe JAILLET)
Date: Tue, 8 Nov 2016 08:18:04 +0100
Subject: [PATCH] serial: sirf: Simplify a test
In-Reply-To: <2916662.De1FDumaQl@wuerfel>
References: <20161101070333.12255-1-christophe.jaillet@wanadoo.fr>
 <2916662.De1FDumaQl@wuerfel>
Message-ID: <39a1050e-fb64-a6e5-8939-4e01631e59ea@wanadoo.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 07/11/2016 ? 14:50, Arnd Bergmann a ?crit :
> On Tuesday, November 1, 2016 8:03:33 AM CET Christophe JAILLET wrote:
>> 'dmaengine_prep_dma_cyclic()' does not return an error pointer, so the test
>> can be simplified to be more consistent.
>>
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> The change looks correct in principle. It would be good to automate looking
> for other instances of this bug. How did you find it? Do you have e.g. a
> coccinelle script or did you just stumble over the issue by accident?
Hi,

You can have an idea of the strategy used in this post:
    https://lkml.org/lkml/2016/11/1/388

Julia is currently working on a more complete strategy in order to find 
such issues.

In the meantime, if you want, I can send the coccinelle scripts used.

Best regards,
CJ
