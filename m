From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 2 Apr 2012 22:57:14 -0300
Subject: [PATCH] ARM: versatile: fix build failure in pci.c
In-Reply-To: <CAP=VYLpim2TCMO5nDVNe0bdm9ZQ+czUWNpxxWugDzrHO6aYVAQ@mail.gmail.com>
References: <1333410505-17257-1-git-send-email-paul.gortmaker@windriver.com>
 <CAOMZO5CUktQ78dbpqpepLvQXme7OcaxXnCcDsxZ+JahOjjEt=Q@mail.gmail.com>
 <CAP=VYLpim2TCMO5nDVNe0bdm9ZQ+czUWNpxxWugDzrHO6aYVAQ@mail.gmail.com>
Message-ID: <CAOMZO5A-+tcz6ewTykXL33opRVP9U4o7Ltdkbr7LLqWMBQczSQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 2, 2012 at 10:01 PM, Paul Gortmaker
<paul.gortmaker@windriver.com> wrote:

> I see. ?Well, there weren't any follow ups to it but I would say that
> passing both sys->resources and sys both side-by-side at the same
> time doesn't really make sense. ?I think just passing in sys by itself
> as I did is a cleaner way to go, wouldn't you agree?

Yes, I agree.
