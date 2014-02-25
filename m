From: olof@lixom.net (Olof Johansson)
Date: Tue, 25 Feb 2014 08:51:37 -0800
Subject: linux-next: manual merge of the staging tree with the arm-soc tree
In-Reply-To: <20140225164921.GA4458@kroah.com>
References: <20140225170944.d322d9868871bc2f669b92e5@canb.auug.org.au>
 <20140225164921.GA4458@kroah.com>
Message-ID: <CAOesGMiTZN3z441d3bOaCcF8Zsss4WZv6YkH9CJpZtTBGxadWw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 25, 2014 at 8:49 AM, Greg KH <greg@kroah.com> wrote:
> On Tue, Feb 25, 2014 at 05:09:44PM +1100, Stephen Rothwell wrote:
>> Hi Greg,
>>
>> Today's linux-next merge of the staging tree got a conflict in
>> arch/arm/boot/dts/imx53-qsb.dts between commit d5eb195f26fa ("ARM: dts:
>> i.MX53: move common QSB nodes to new file") from the arm-soc tree and
>> commit 17b5001b5143 ("imx-drm: convert to componentised device support")
>> from the staging tree.
>>
>> I fixed it up (see at bottom) and can carry the fix as necessary (no
>> action is required).  I also added the following fix up patch:
>
> I think it's right, but I really have no idea about any of these.  I'll
> defer to Russell to ensure they are correct.

We normally merge all dts changes through arm-soc to avoid these kind
of conflicts. Since your tree is a stable one there isn't much to do
about it, but I'd appreciate it if we just got those parts of the
patch series in the future to avoid these situations. We've been bit
by it before.


-Olof
