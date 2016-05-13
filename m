From: shijie.huang@arm.com (Huang Shijie)
Date: Fri, 13 May 2016 09:49:06 +0800
Subject: [PATCH] deb-pkg: add the shared header file for arm64
In-Reply-To: <573491A2.7070809@suse.com>
References: <1463043837-4348-1-git-send-email-shijie.huang@arm.com>
 <573491A2.7070809@suse.com>
Message-ID: <20160513014905.GA15321@sha-win-210.asiapac.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 12, 2016 at 04:22:26PM +0200, Michal Marek wrote:
> On 2016-05-12 11:03, Huang Shijie wrote:
> > The arch/arm/include/asm/opcodes.h is also used by the arm64.
> > This patch copies it to the arm64 deb package.
> > 
> > Signed-off-by: Huang Shijie <shijie.huang@arm.com>
> > ---
> >  scripts/package/builddeb | 6 ++++++
> >  1 file changed, 6 insertions(+)
> 
> 
> Hi Huang,
> 
> this is fixed (admittedly in a more aggressive way) by 962475ac2f96
> ("builddeb: fix missing headers in linux-headers package") in linux-next.
okay. got it.

thanks
Huang Shijie
