From: dianders@chromium.org (Doug Anderson)
Date: Wed, 2 May 2018 09:37:15 -0700
Subject: [PATCH v2 1/2] regulator: dt-bindings: add QCOM RPMh regulator
 bindings
In-Reply-To: <39b676d2ba7dac2436196cc5a090c6f151498dc8.1523673467.git.collinsd@codeaurora.org>
References: <cover.1523673467.git.collinsd@codeaurora.org>
 <39b676d2ba7dac2436196cc5a090c6f151498dc8.1523673467.git.collinsd@codeaurora.org>
Message-ID: <CAD=FV=UDUKg58xe+3C5QUbFwFkO8d3c_tzxmfPDzdv1KXZ3W9g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Apr 13, 2018 at 7:50 PM, David Collins <collinsd@codeaurora.org> wrote:
> +- vdd_l26-supply
> +- vdd_lvs1_lvs2-supply
> +- vdd_lvs1_lvs2-supply
> +       Usage:      optional (PM8998 only)
> +       Value type: <phandle>
> +       Definition: phandle of the parent supply regulator of one or more of the
> +                   regulators for this PMIC.

One small additional nit here is that "vdd_lvs1_lvs2-supply" is listed twice.

Also on the schematics (and in the PM8998 datasheet) I have this is
"VIN_LVS_1_2".  It seems like you should be consistent here and call
this "vin-lvs-1-2-supply".

-Doug
