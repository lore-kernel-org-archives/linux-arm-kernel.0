From: peter@hurleysoftware.com (Peter Hurley)
Date: Fri, 4 Mar 2016 07:52:00 -0800
Subject: [PATCH v3 5/7] ACPI: serial: implement earlycon on ACPI DBG2 port
In-Reply-To: <56D987BC.7070209@linaro.org>
References: <1456749726-30261-1-git-send-email-aleksey.makarov@linaro.org>
 <1456749726-30261-6-git-send-email-aleksey.makarov@linaro.org>
 <56D5BAFF.6080008@hurleysoftware.com> <56D5C9F5.5060301@linaro.org>
 <56D878D4.4000902@hurleysoftware.com> <56D987BC.7070209@linaro.org>
Message-ID: <56D9AF20.1060701@hurleysoftware.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/04/2016 05:03 AM, Aleksey Makarov wrote:

> Actually it was Mark Salter who asked to introduce such macros.
> 
> https://lkml.kernel.org/g/1441730339.5459.8.camel at redhat.com

I wasn't copied on that series, sorry.


> I think reusing the OF functions is a good decision.

But you're not reusing the OF functions; you're duplicating them.
