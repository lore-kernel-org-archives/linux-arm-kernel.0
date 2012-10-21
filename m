From: manabian@gmail.com (Joachim Eastwood)
Date: Sun, 21 Oct 2012 22:26:34 +0200
Subject: [PATCH 1/5] net/cadence: get rid of HAVE_NET_MACB
In-Reply-To: <20121021183005.GA18964@game.jcrosoft.org>
References: <1350829392-3812-1-git-send-email-manabian@gmail.com>
 <1350829392-3812-2-git-send-email-manabian@gmail.com>
 <20121021183005.GA18964@game.jcrosoft.org>
Message-ID: <CAGhQ9VxxjU0qNTQtS=QHw-eHV10hMjE6DBZhFunr27yvdmX+rg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 21, 2012 at 8:30 PM, Jean-Christophe PLAGNIOL-VILLARD
<plagnioj@jcrosoft.com> wrote:
> On 16:23 Sun 21 Oct     , Joachim Eastwood wrote:
>> macb is a platform driver and there is nothing that prevents
>> this driver from being built on non-ARM/AVR32 platforms.
> if you want to drop the HAVE_NET_MACB you need to drop it everywher in one
> patch

Breaking it up in several patches doesn't seem to cause any build
failures and I did this in case the patches were going into different
git trees.

regards
Joachim Eastwood
