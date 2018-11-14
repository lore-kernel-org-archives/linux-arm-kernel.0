From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Wed, 14 Nov 2018 14:17:01 +0100
Subject: [PATCH v2 0/2] Staging: vchi: Add license id and change int type
In-Reply-To: <20181113003733.9615-1-andrealmeid@riseup.net>
References: <20181113003733.9615-1-andrealmeid@riseup.net>
Message-ID: <aae766b2-36da-2803-e48f-d1ff7e7e7910@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andre,

Am 13.11.2018 um 01:37 schrieb andrealmeid at riseup.net:
> From: Andr? Almeida <andrealmeid@riseup.net>
>
> Fix the following checkpatch issues:
>
> WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
> CHECK: Prefer kernel type 's32' over 'int32_t'
>
> Changes in v2:
> - Splits commits in a patch set
> - Fixes licenses in SPDX identifier
> - Adds a more descriptive commit message
>
> v1: https://www.spinics.net/lists/arm-kernel/msg685603.html
>
> Andr? Almeida (2):
>   staging: vchi: change type 'int32_t' to 's32'
>   stagin: vchi: Add SPDX-License-Identifier
>
>  drivers/staging/vc04_services/interface/vchi/vchi_mh.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
sorry i didn't noticed this before my Ack, but Nicolas wants to remove
the whole file in his patch series.

Stefan
