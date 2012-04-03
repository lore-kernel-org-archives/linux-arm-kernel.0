From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Tue, 3 Apr 2012 15:09:36 -0400
Subject: [PATCH] ARM: versatile: fix build failure in pci.c
In-Reply-To: <CAErSpo5RiDgfXHB30rOTco6CjhH4Nzovhvddifk9i=tb4QKtNQ@mail.gmail.com>
References: <1333410505-17257-1-git-send-email-paul.gortmaker@windriver.com>
 <201204030819.48798.arnd@arndb.de> <4F7AFF61.3070803@windriver.com>
 <201204031426.22652.arnd@arndb.de>
 <CAErSpo5RiDgfXHB30rOTco6CjhH4Nzovhvddifk9i=tb4QKtNQ@mail.gmail.com>
Message-ID: <4F7B4AF0.7080208@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12-04-03 12:44 PM, Bjorn Helgaas wrote:

[...]

> 
> Since this only affects arm, do you want to handle the fix entirely in
> the arm tree?  If you want me to push something through PCI, I can do
> that, too.  Sorry for the breakage.

Olof already applied my patch to fixes, so I don't
think there is any requirement for immediate action.

You and Arnd can work out whether you want to use
offsets or not on the versatile at your leisure.

Thanks,
Paul.

> 
> Bjorn
