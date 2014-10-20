From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 20 Oct 2014 15:47:42 +0200
Subject: [PATCH v2 1/5] Documentation: DT: Renamed of-serial.txt to
 8250.txt
In-Reply-To: <1413539665-11484-2-git-send-email-chunyan.zhang@spreadtrum.com>
References: <1413539665-11484-2-git-send-email-chunyan.zhang@spreadtrum.com>
Message-ID: <1938561.uq5BpWofVY@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 17 October 2014 17:54:21 Chunyan Zhang wrote:
> The file of-serial.txt was only for 8250 compatible UART implementations,
> so renamed it to 8250.txt to avoid confusing other persons.
> 
> Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
> ---
>  Documentation/devicetree/bindings/serial/8250.txt  |   50 ++++++++++++++++++++
>  .../devicetree/bindings/serial/of-serial.txt       |   50 --------------------
>  2 files changed, 50 insertions(+), 50 deletions(-)
> 

Patch looks good, but please use 'git format-patch -M' when generating it,
to avoid having the whole add/remove in the patch, for easier review.

	Arnd
