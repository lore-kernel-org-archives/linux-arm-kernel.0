From: julien.grall@citrix.com (Julien Grall)
Date: Mon, 14 Sep 2015 15:46:12 +0100
Subject: [PATCH v4 00/20] xen/arm64: Add support for 64KB page in Linux
In-Reply-To: <55F6D9DC.8060607@citrix.com>
References: <1441640038-23615-1-git-send-email-julien.grall@citrix.com>
 <55F68BC9.6020509@citrix.com> <55F6A437.3040403@citrix.com>
 <55F6A9DB.8040503@citrix.com> <55F6ADAE.1010609@citrix.com>
 <55F6B8CC.5090406@citrix.com> <55F6C1D2.7010206@citrix.com>
 <55F6D9DC.8060607@citrix.com>
Message-ID: <55F6DDB4.5000403@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/09/15 15:29, Roger Pau Monn? wrote:
>> To give you an example, Centos 7, which will support Xen and only 64KB
>> page granularity, will be supported for years. Dropping any splitting in
>> a short future (3-5 years) will just break those guests to boot on Xen.
> 
> Can't the patches to support 64KB grants be backported to CentOS? In the
> past you said that distros had no problem in picking the needed Xen
> patches for 64KB support, I don't see how that would be different.

Centos 7 is not yet released so it's more easy to get patch in. I don't
know what will be position when the guest is shipped.

I bet they will still want to support 64KB with older Xen (i.e where
64KB grant is not supported).

Anyway, I don't expect to see the 64KB grants support before next year
as my TODO list is already pretty full. So let's talk about it when I
(or someone else) will send an RFC to extend the grant size.

Regards,

-- 
Julien Grall
