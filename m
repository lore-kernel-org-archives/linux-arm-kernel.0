From: mmarek@suse.com (Michal Marek)
Date: Thu, 12 May 2016 16:22:26 +0200
Subject: [PATCH] deb-pkg: add the shared header file for arm64
In-Reply-To: <1463043837-4348-1-git-send-email-shijie.huang@arm.com>
References: <1463043837-4348-1-git-send-email-shijie.huang@arm.com>
Message-ID: <573491A2.7070809@suse.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016-05-12 11:03, Huang Shijie wrote:
> The arch/arm/include/asm/opcodes.h is also used by the arm64.
> This patch copies it to the arm64 deb package.
> 
> Signed-off-by: Huang Shijie <shijie.huang@arm.com>
> ---
>  scripts/package/builddeb | 6 ++++++
>  1 file changed, 6 insertions(+)


Hi Huang,

this is fixed (admittedly in a more aggressive way) by 962475ac2f96
("builddeb: fix missing headers in linux-headers package") in linux-next.

Michal
