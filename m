From: rmallon@gmail.com (Ryan Mallon)
Date: Sun, 10 Jun 2012 10:15:31 +1000
Subject: ARM/CIRRUS LOGIC EP93XX ARM ARCHITECTURE - patch proposal:  for
 ep9302 i2c support is not enabled in kernel - submit patch to enable it &
 merge it in the newer kernels
In-Reply-To: <1621975213.53747.1339245434729.JavaMail.apache@nm41.abv.bg>
References: <1621975213.53747.1339245434729.JavaMail.apache@nm41.abv.bg>
Message-ID: <4FD3E723.2080609@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/06/12 22:37, Todor Colov wrote:
>
> Dear all,
>
> I'm contacting you as your are the offical maintainers of "ARM/CIRRUS LOGIC EP93XX ARM ARCHITECTURE "
>
>  For ep9302 sub-architecture "i2c" support is not enabled in the recet kernels. i2c support is needed when external RTC are used.
>

Hi Todor,

Thanks for the patch. I need a signed-off-by line from you before I can apply this though. Something like:

  Signed-off-by: Todor Colov <todorcolov@abv.bg>

For future reference, please read Documentation/SubmittingPatches. Your email should have a subject line like "[PATCH] arm: ep93xx: Enable i2c support for ep9302" and you should have a description of what the patch does, followed by your signed-off-by, followed by the patch (in line in the email, no attachments).

For this patch, if you just send me the signed-off-by line you would like to use I will fix up the rest.

Thanks,
~Ryan
 
