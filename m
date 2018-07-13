From: ijc@debian.org (Ian Campbell)
Date: Fri, 13 Jul 2018 11:02:39 +0100
Subject: [RFC PATCH 0/2] efi: add contents of LinuxExtraArgs EFI var to
 command line
In-Reply-To: <CAKv+Gu9+RYbtD8Ce_AW_1jvTei6dC5LwiiMgSUWDKLs8f7S+eA@mail.gmail.com>
References: <20180704154919.18564-1-ard.biesheuvel@linaro.org>
 <4bd9bee6-f2b9-3197-c205-fec104fd1090@infradead.org>
 <CAKv+Gu9+RYbtD8Ce_AW_1jvTei6dC5LwiiMgSUWDKLs8f7S+eA@mail.gmail.com>
Message-ID: <1531476159.18353.31.camel@debian.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2018-07-13 at 08:15 +0200, Ard Biesheuvel wrote:
> I still think we should not be using DMI, though.

Would a quirk be acceptable if keyed on something other than DMI?

Are there some other options, perhaps some property of the ACPI tables
proper? Something which can be queried from UEFI perhaps? (I'm really
grasping at straws, but maybe someone has a smart idea).

Ian.
