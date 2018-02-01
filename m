From: ada@thorsis.com (Alexander Dahl)
Date: Thu, 01 Feb 2018 09:29:24 +0100
Subject: Patch submission process about at91 DTS
In-Reply-To: <20180131170453.GA16869@tp.shaiton.org>
References: <20180131170453.GA16869@tp.shaiton.org>
Message-ID: <2019072.DmFbzY6CId@ada>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello K?vin,

Am Mittwoch, 31. Januar 2018, 18:04:53 CET schrieb K?vin Raymond:
> My current patches are based an tested over the linux repo[0] against the
> master branch (4e19652 Update the RISC-V MAINTAINERS file).
> 
> Should I rebase them against the linux-at91[1] repository? Which branch,
> at91-next? I would love them to reach the 4.14 branch but am not sure of
> the right path to submit those changes.

As far as I understood the process, it is common to base those patches on the 
last tag of Linus' tree at the time sending. At the moment this would be 
v4.15, in two weeks it will be v4.16-rc1. If you rebase it on top another 
tree, add this information to your introductory mail.

Greets
Alex
