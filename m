From: marcel@holtmann.org (Marcel Holtmann)
Date: Mon, 30 Jul 2018 14:01:31 +0200
Subject: [PATCH v6 2/4] Bluetooth: Add new quirk for non-persistent setup
 settings
In-Reply-To: <d20e070679bb40bff011f5a74f531e1b662d08a5.1532060309.git.sean.wang@mediatek.com>
References: <cover.1532060309.git.sean.wang@mediatek.com>
 <d20e070679bb40bff011f5a74f531e1b662d08a5.1532060309.git.sean.wang@mediatek.com>
Message-ID: <A25EEA4C-6A6D-4189-B259-2ABB8A4D1A59@holtmann.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sean,

> Add a new quirk HCI_QUIRK_NON_PERSISTENT_SETUP allowing that a quirk that
> runs setup() after every open() and not just after the first open().
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
> include/net/bluetooth/hci.h | 9 +++++++++
> net/bluetooth/hci_core.c    | 3 ++-
> 2 files changed, 11 insertions(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel
