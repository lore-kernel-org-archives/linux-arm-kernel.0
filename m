From: lkundrak@v3.sk (Lubomir Rintel)
Date: Sun, 22 Jun 2014 12:45:43 +0200
Subject: [RFC PATCH 2/3] Enable BCM2835 mailbox support
In-Reply-To: <5232F7C2.3070408@yahoo.com.au>
References: <5232F7C2.3070408@yahoo.com.au>
Message-ID: <1403433943.532.1.camel@goatlord.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Craig,

On Fri, 2013-09-13 at 23:32 +1200, Craig McGeachie wrote:
> Reimplement BCM2835 mailbox support as a device registered with the
> general purpose mailbox framework.

As the work on common mailbox framework progressed, I've updated the
driver to work with v7 of it (I've also ported the cpufreq and vchiq
drivers, which I'd like to post once the mailbox framework and your
drivers are in):

https://github.com/hackerspace/rpi-linux/commits/lr-vchiq-new-mailbox

I'm not sending inline patches for review, since neither the framework
nor your your mbox and thermal drivers are in yet, but I'm wondering if
you could take a look and eventually fold the changes back into your
drivers? (I've kept them in separate commits in my tree, so that it's
easy for you to keep track of the changes).

Thank you,
Lubo
