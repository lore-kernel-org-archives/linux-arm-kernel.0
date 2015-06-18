From: p.fedin@samsung.com (Pavel Fedin)
Date: Thu, 18 Jun 2015 18:03:16 +0300
Subject: [PATCH 13/13] KVM: arm64: enable ITS emulation as a virtual MSI
 controller
In-Reply-To: <5582D410.60708@arm.com>
References: <1432893209-27313-1-git-send-email-andre.przywara@arm.com>
 <1432893209-27313-14-git-send-email-andre.przywara@arm.com>
 <558284B4.104@linaro.org> <5582D410.60708@arm.com>
Message-ID: <01a401d0a9d7$e87997d0$b96cc770$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Hello!

> But that fails compilation on ARM (which uses this file as well),
> because we have a dummy fail function in the header if
> CONFIG_HAVE_KVM_MSI is not defined.

 May be then remove that fail function too? Too many #ifdef's are not good...

Kind regards,
Pavel Fedin
Expert Engineer
Samsung Electronics Research center Russia
