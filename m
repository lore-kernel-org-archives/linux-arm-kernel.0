From: david.woodhouse@intel.com (Woodhouse, David)
Date: Wed, 27 Mar 2013 22:11:53 +0000
Subject: [PATCH v3] pinctrl: mvebu: prevent walking off the end of group
 array
In-Reply-To: <CACRpkdb-CdmzszyixBLGdZjXJXzef26u0qN9xWcrYa3JbAD3Ow@mail.gmail.com>
References: <1363196884-20193-1-git-send-email-jason@lakedaemon.net>
 <1363434272-23172-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <CACRpkdb-CdmzszyixBLGdZjXJXzef26u0qN9xWcrYa3JbAD3Ow@mail.gmail.com>
Message-ID: <1364422304.14860.9.camel@i7.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-03-27 at 23:06 +0100, Linus Walleij wrote:
> Is it so critical that it needs to be tagged for stable as well
> then tell me.
> 
> If it's non-critical enough to live on for -next then tell me.

I don't think it's critical. It'll probably never trigger in practice.

-- 
                   Sent with MeeGo's ActiveSync support.

David Woodhouse                            Open Source Technology Centre
David.Woodhouse at intel.com                              Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 6242 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130327/30d1c6d2/attachment-0001.bin>
