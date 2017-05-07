From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sun, 07 May 2017 14:05:26 +0100
Subject: [PATCH v7 18/24] KVM: arm64: vgic-its: Add infrastructure for
 table lookup
In-Reply-To: <1494084283-12723-19-git-send-email-eric.auger@redhat.com> (Eric
 Auger's message of "Sat, 6 May 2017 17:24:37 +0200")
References: <1494084283-12723-1-git-send-email-eric.auger@redhat.com>
 <1494084283-12723-19-git-send-email-eric.auger@redhat.com>
Message-ID: <87d1bkkeax.fsf@on-the-bus.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 06 2017 at  4:24:37 pm BST, Eric Auger <eric.auger@redhat.com> wrote:
> Add a generic scan_its_table() helper whose role consists in
> scanning a contiguous table located in guest RAM and applying
> a callback on each entry. Entries can be handled as linked lists
> since the callback may return an id offset to the next entry and
> also indicate whether the entry is the last one.
>
> Helper functions also are added to compute the device/event ID
> offset to the next DTE/ITE.
>
> compute_next_devid_offset, compute_next_eventid_offset and
> scan_table will become static in subsequent patches
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Christoffer Dall <cdall@linaro.org>

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead, it just smell funny.
