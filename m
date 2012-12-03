From: tim.bird@am.sony.com (Tim Bird)
Date: Mon, 3 Dec 2012 15:51:03 -0800
Subject: nfs root not responding?
In-Reply-To: <slrnkbo3ca.1p8.narkewoody@zuhnb712.local.com>
References: <slrnkbgkqq.2kq.narkewoody@zuhnb712.local.com>
 <20121130083252.B4301200171@gemini.denx.de>
 <slrnkbo1et.1p8.narkewoody@zuhnb712.local.com>
 <slrnkbo3ca.1p8.narkewoody@zuhnb712.local.com>
Message-ID: <50BD3AE7.6050807@am.sony.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/02/2012 06:26 PM, Woody Wu wrote:> By enabling the debug output in my Ethernet driver, I captured some
> network traffics.
...

Rather than try to decode this by hand, I recommend you use Wireshark.
It has proven invaluable to me to identify and resolve networking
problems on boot (particular with NFS root-mounted file systems).

WireShark can decode the DHCP packets and the NFS request headers, which
is very handy.  You can tell which side of the connection is sending wrong
information, or not responding.  BTW - in case it's not obvious, you run
it on host and capture the ethernet traffic on the connection between your
host and target.
 -- Tim

=============================
Tim Bird
Architecture Group Chair, CE Workgroup of the Linux Foundation
Senior Staff Engineer, Sony Network Entertainment
=============================
