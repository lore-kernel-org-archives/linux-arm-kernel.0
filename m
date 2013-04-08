From: bhelgaas@google.com (Bjorn Helgaas)
Date: Mon, 8 Apr 2013 14:32:09 -0600
Subject: [PATCHv7 04/17] pci: infrastructure to add drivers in
 drivers/pci/host
In-Reply-To: <20130328082436.317d698a@skate>
References: <1364395234-11195-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1364395234-11195-5-git-send-email-thomas.petazzoni@free-electrons.com>
 <CAAfodu2t4j4ZASzdaKV0QarffXRwMgkMESGy=dDq1oMfTANEeg@mail.gmail.com>
 <20130328082436.317d698a@skate>
Message-ID: <CAErSpo61=gqnNkUYhsu88UUBRQN0SBynG07mby1f3HJUm=oZKA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 28, 2013 at 1:24 AM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:
> Dear Neil Greatorex,
>
> On Thu, 28 Mar 2013 00:28:02 +0000, Neil Greatorex wrote:
>
>> Surely this patch should include the drivers/pci/host/Makefile or it will
>> not build?
>
> Ah, correct. I'll fix that up in the v8. Thank you for noticing!

With the fix, looks OK to me.

Bjorn
