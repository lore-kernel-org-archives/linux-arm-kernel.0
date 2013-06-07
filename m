From: henrik@henriknordstrom.net (Henrik =?ISO-8859-1?Q?Nordstr=F6m?=)
Date: Fri, 07 Jun 2013 12:26:57 +0200
Subject: [Arm-netbook] getting allwinner SoC support upstream (was Re:
 Uploading linux (3.9.4-1))
In-Reply-To: <CAPweEDyYt+pN+UaFuqWL5RrHpyuq_4So-tArmx3dr=0wLS+hwQ@mail.gmail.com>
References: <CAPweEDx3mAy40BZrzrKPRbvg7vKMj7KevDQ3m_v4p6Yo50eSGg@mail.gmail.com>
 <1370475609.20454.44.camel@localhost>
 <CAPweEDwS3tR=wh-bZJb3vqR8fVQra=3XxDitowGRdH9c7WRfmQ@mail.gmail.com>
 <1733666.lHUBcfUXq9@flatron>
 <CAPweEDzYLDzh_-OWU61dtVhajZ40QpQgZKHFYDsh3FgF=r9_ag@mail.gmail.com>
 <20130606131042.GN18614@n2100.arm.linux.org.uk>
 <CAPweEDyYt+pN+UaFuqWL5RrHpyuq_4So-tArmx3dr=0wLS+hwQ@mail.gmail.com>
Message-ID: <1370600817.9983.7.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

fre 2013-06-07 klockan 09:02 +0100 skrev luke.leighton:

>  ok.  so.  we come back to the question again: what shall i propose to
> them that they consider doing, and what benefit would it be to them to
> do so?

Just tell them that the kernel is moving to a different configuration
syntax called Device Tree, but apart from updating kernel drivers to the
new way of configuring things it only have minor impact on their
envionment. It is still possible to use the fex file for all board
configuration details, only requires a small tool for translating fex to
device tree.

The change only impacts kernel, and a small change to their SDK build
scripts to also build the device tree from the fex.

It is no big deal really in structural terms. There is far bigger
structural changes in the kernel which coincides with this and will
require some developer time to adjust for. Had they upstreamed their
changes earlier then...

Regards
Henrik
