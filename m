From: hpa@zytor.com (H. Peter Anvin)
Date: Tue, 05 Jul 2011 15:35:46 -0700
Subject: [RFC] virtio: expose for non-virtualization users too
In-Reply-To: <1309874774-31689-1-git-send-email-ohad@wizery.com>
References: <1309874774-31689-1-git-send-email-ohad@wizery.com>
Message-ID: <4E1391C2.2090904@zytor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/05/2011 07:06 AM, Ohad Ben-Cohen wrote:
> virtio has been so far used only in the context of virtualization,
> and the virtio Kconfig was sourced directly by the relevant arch
> Kconfigs when VIRTUALIZATION was selected.
> 
> Now that we start using virtio for inter-processor communications,
> we need to source the virtio Kconfig outside of the virtualization
> scope too.
> 

Seems reasonable to me.

	-hpa
