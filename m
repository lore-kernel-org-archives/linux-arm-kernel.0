From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 18 Nov 2012 11:32:39 +0000
Subject: [PATCH V3] Add support for generic BCM SoC chipsets
In-Reply-To: <CAGFynZ-C4ZZiBMT6rff0U7kBZ55qZD7wMar7mDs9mu5f0v6BRA@mail.gmail.com>
References: <1352843517-31328-1-git-send-email-csd@broadcom.com>
 <CAA-5wcAyyh5VRySrNe5Efzbwb9n_4fDxHV4Jzz79H17NUHBtjA@mail.gmail.com>
 <CAGFynZ-C4ZZiBMT6rff0U7kBZ55qZD7wMar7mDs9mu5f0v6BRA@mail.gmail.com>
Message-ID: <201211181132.39586.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 18 November 2012, Christian Daudt wrote:
> On an administrative question: Stephen sent me a reviewed-by that
> effectively applied to V4 of the patch. I dropped it for V5 as this is
> not the exact patchset that he reviewed. Is the expected procedure
> that new versions of patches carry previous reviewed-by or not ? I
> could not find any reference to that in the submittingpatches doc

Usually you should keep the reviewed-by tag as you only make small
changes to other comments. If you do substantial changes, best ask
the reviewers to look at the new version as well.

	Arnd
