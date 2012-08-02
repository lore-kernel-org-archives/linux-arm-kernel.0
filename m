From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Thu, 2 Aug 2012 08:15:20 +0200
Subject: [PATCH v3 00/10] ARM: tegra: Add PCIe device tree support
In-Reply-To: <5019611A.2060804@wwwdotorg.org>
References: <1343332512-28762-1-git-send-email-thierry.reding@avionic-design.de>
 <50180547.9040603@wwwdotorg.org>
 <20120801063545.GA26791@avionic-0098.adnet.avionic-design.de>
 <5019611A.2060804@wwwdotorg.org>
Message-ID: <20120802061520.GE12241@avionic-0098.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 01, 2012 at 11:02:18AM -0600, Stephen Warren wrote:
> On 08/01/2012 12:35 AM, Thierry Reding wrote:
> > On Tue, Jul 31, 2012 at 10:18:15AM -0600, Stephen Warren wrote:
> >> On 07/26/2012 01:55 PM, Thierry Reding wrote:
> >>> This patch series adds support for device tree based probing of
> >>> the PCIe controller found on Tegra SoCs.
> >> 
> >> Thierry,
> >> 
> >> I think one thing that would help here would be to split up this
> >> series into one per subsystem, and to get all the dependencies
> >> merged by the respective maintainers. Preferably, each subsystem
> >> would export a stable branch (perhaps consisting of just these
> >> patches) that I can then merge into the Tegra tree and use as a
> >> basis for the PCIe driver itself. Hopefully this approach will
> >> get more traction on all the non-Tegra changes. Does that sound
> >> like a good plan?
> > 
> > I don't understand. The series is already split up into
> > per-subsystem patches. I just didn't want to post them separately
> > so everybody on Cc would be able to see the big picture and the
> > reason why the patch was required.
> 
> There are separate patches that touch the different subsystems, but
> they're all scattered throughout the one series, rather than having e.g.:
> 
> * a series for the PCI tree
> * a series for the ARM core tree
> * a series for the OF/DT tree
> * a series for the Tegra tree, which indicates it depends on all of those.
> 
> I'm wondering if the reason you haven't seen much discussion/Acks from
> the maintainers of the non-Tegra trees is because this is a big scary
> series that touches a lot of stuff, and it's not necessarily clear for
> people unfamiliar with it why they're being CCd on it.

I see. If you think it'll help I can certainly split them up as you
suggested. I just thought it might be useful for everybody to know the
context. At least from my own experience I get annoyed when I'm Cc'ed
on a single patch in a larger series because it means I need to look
through other archives for the context.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120802/c440c02f/attachment.sig>
