From: olof@lixom.net (Olof Johansson)
Date: Wed, 26 Aug 2015 13:02:18 -0700
Subject: [PATCH 5/5] MAINTAINERS: add entry for the Broadcom Northstar
 Plus SoCs
In-Reply-To: <20150826190046.GB4171@broadcom.com>
References: <1440092861-25825-1-git-send-email-jonmason@broadcom.com>
 <CAOesGMioBQY9qy-S8kMJmo_=B6-KZiUkd=Ns1Uo2dGu0BiqppQ@mail.gmail.com>
 <20150826190046.GB4171@broadcom.com>
Message-ID: <CAOesGMhS6vA_MToAYhU18Dwj=QXdmf3MVSwo33qR2kYJ=qrh5g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 26, 2015 at 12:00 PM, Jon Mason <jonmason@broadcom.com> wrote:
> On Tue, Aug 25, 2015 at 04:42:42PM -0700, Olof Johansson wrote:
>> On Thu, Aug 20, 2015 at 10:47 AM, Jon Mason <jonmason@broadcom.com> wrote:
>> > Modify the iProc MAINTAINER to cover the Nortstar Plus SoCs, and add me
>> > to the list of people responsible for it.
>>
>> That's not what this patch does. It removes CYGNUS from the
>> description as well. Hmm?
>
> iProc is a family of SoCs that includes Cygnus, Northstar (BCM5301X),
> Northstar Plus, Northstar 2, and a number of other platforms.  I
> removed the "Cygnus" for that reason.

Ok, feel free to add that info to the commit message in case others
see the same and wonder what happened.

>> I'm also not a fan of the complex patterns, but that's more of a
>> bikeshedding comment. Does Broadcom really not have a bit more
>> systematic naming than this? :)
>
> Per Florian's comment, it's a bit of a mess internally.

Unfortunate. Hopefully the chaotic product naming doesn't have to leak
quite everywhere in the tree and things can be referred to by family,
etc. :)


-Olof
