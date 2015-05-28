From: stillcompiling@gmail.com (Joshua Clayton)
Date: Thu, 28 May 2015 10:41:39 -0700
Subject: imx6 fsl,fiq-stream-filter
In-Reply-To: <A34315704930CF44BA74E64F19E02E917DEEE3FC@S1P5DAG1A.EXCHPROD.USA.NET>
References: <A34315704930CF44BA74E64F19E02E917DEEE3FC@S1P5DAG1A.EXCHPROD.USA.NET>
Message-ID: <1808860.4aMo44FlnA@jclayton-pc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, May 28, 2015 05:04:57 PM Uhl, Joe wrote:
> Hello,
> Is it possible to disable dma transfers on ssi1 using FIQ instead?

In theory, yes, but using a fiq is not a straightforward change on recent 
kernel versions.

Freescale FIQ demo code has not been updated since their 3.0.35 kernel, which 
was before the majority of the devicetree migration. (and it was a pretty ugly 
hack, even then). 

have a look at http://thread.gmane.org/gmane.linux.ports.arm.kernel/333901
To get an idea what might be involved.

...

> ----------------------------------------------------------------------------
> ------------------------------------------------ Confidentiality
> Requirement: This communication, including any attachment(s), may contain
> confidential information and is for the sole use of the intended
> recipient(s). If you are not the intended recipient, you are hereby
> notified that you have received this communication in error and any
> unauthorized review, use, disclosure, dissemination, distribution or
> copying of it or its contents is strictly prohibited.  If you have received
> this communication in error, please notify the sender immediately by
> telephone or e-mail and destroy all copies of this communication and any
> attachments.
> 
^
Please be aware that disclaimers like the above are not appropriate for 
communications on a public mailing list. Some important people have been 
advised by legal counsel not to respond to you at all when you include such 
boilerplate.

~Joshua Clayton
