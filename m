From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 23 Jul 2013 14:35:00 -0300
Subject: [PATCH v8 00/28] MBus DT binding for Armada 370/XP and Kirkwood
In-Reply-To: <CAOesGMh5GjCkaGX1O1VdkQUKdM8z0XPEc08OFPjJcGgP6s9nRw@mail.gmail.com>
References: <1374586292-4941-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <CAOesGMh5GjCkaGX1O1VdkQUKdM8z0XPEc08OFPjJcGgP6s9nRw@mail.gmail.com>
Message-ID: <20130723173459.GA11373@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof,

On Tue, Jul 23, 2013 at 10:10:31AM -0700, Olof Johansson wrote:
> On Tue, Jul 23, 2013 at 6:31 AM, Ezequiel Garcia
> <ezequiel.garcia@free-electrons.com> wrote:
> > After Andrew Lunn reported [1] this work need to take account of Kirkwood
> > to prevent breaking PCIe on such platform, here's a new version adding
> > MBus DT binding for Kirkwood and in particular using it to declare PCIe
> > properly.
> 
> This is a prime example of someone sending a whole patch series to the
> devicetree mailing list, when only the bindings updates should go
> there. There are a lot of readers of the devicetree lists that can't
> keep up with the volume of email due to this reason.
> 
> So, while I'm commenting on your email, this goes for everybody
> mailing to this list (and I expect to repeat myself a few times in the
> weeks and months ahead): Do not post the driver updates to the
> devicetree list, only the bindings updates.
> 

Okey, got it. Won't happen again.

Thanks for the notice,
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
