From: slash.tmp@free.fr (Mason)
Date: Wed, 15 Mar 2017 17:13:50 +0100
Subject: Enumerating an empty bus hangs the entire system
In-Reply-To: <20170315160238.GB5073@bhelgaas-glaptop.roam.corp.google.com>
References: <1eeea8ff-0840-a005-38b4-61f3c253cee1@free.fr>
 <20170315160238.GB5073@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <135a0b18-caa3-d3c2-8ea5-6959e70e75ac@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/03/2017 17:02, Bjorn Helgaas wrote:

> If checking for link in your accessor is the best you can do, maybe
> that's all you can do.  I thought there was another driver that did
> that, but I can't find it now.  It doesn't seem perfectly safe to me,
> since the link could go down after you check for "link up" and before
> you actually issue the read.

Are you thinking of some hotplug scenario?

My system doesn't support hotplug, and I naively thought that the
link would be down if there is no card, and up shortly after reset
if there is a card.

Regards.
