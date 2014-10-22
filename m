From: bhelgaas@google.com (Bjorn Helgaas)
Date: Wed, 22 Oct 2014 10:49:14 -0600
Subject: [RFC 2/4] PCI: generic: Add support for ARM64 and MSI(x)
In-Reply-To: <20141022155914.GB25939@e102568-lin.cambridge.arm.com>
References: <1411937610-22125-1-git-send-email-suravee.suthikulpanit@amd.com>
 <2430078.s4snyh5OoF@wuerfel>
 <20141001084626.GZ841@e106497-lin.cambridge.arm.com>
 <3256560.C0cZnIlnAv@wuerfel>
 <20141022155914.GB25939@e102568-lin.cambridge.arm.com>
Message-ID: <CAErSpo4DPU6_TO9atpzDbu-X9iddrnBk3QQV4_BcpUCFL4JUdw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 22, 2014 at 9:59 AM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:

> ... I wonder what's the
> best course of action. Putting together all the bits and pieces required
> to remove PCI bios dependency from this patch can take a while, I wonder
> whether we should aim for merging this driver (rebased on top of my port to the
> new parse ranges API) with the ARM/ARM64 ifdeffery and clean it up later
> or aim for the whole thing at once, I am just worried it can take us a while.

I haven't looked at your patches, but "the whole thing at once" is
never *my* goal.  A gradual cleanup is just fine with me.

Bjorn
