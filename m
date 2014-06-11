From: grant.likely@linaro.org (Grant Likely)
Date: Wed, 11 Jun 2014 12:28:40 +0100
Subject: [RFC v2] ARM VM System Specification
In-Reply-To: <20140611095540.GD24286@lvm>
References: <20140328184517.GA27219@cbox> <5397360B.80102@huawei.com>
 <alpine.DEB.2.02.1406111035190.13771@kaball.uk.xensource.com>
 <20140611095540.GD24286@lvm>
Message-ID: <CACxGe6vzGrNxqdanhUX3G-dvN-jVrX9YQyOA==h0Vnv_sf-aTA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 11, 2014 at 10:55 AM, Christoffer Dall
<christoffer.dall@linaro.org> wrote:
> Agree with what Stefano says, and I strongly recommend you reconsider
> your position on FDT vs. ACPI for ARM VMs, but it's completely up to
> you of course :)

Not entirely. The plan right now is to only support ACPI when booting
with UEFI. If they don't use UEFI, then ACPI will not be available. If
OSv only supports ACPI, then it is forced to use the UEFI boot path.

g.
