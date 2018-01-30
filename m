From: robh@kernel.org (Rob Herring)
Date: Tue, 30 Jan 2018 12:53:33 -0600
Subject: [PATCH 2/2] dt-bindings: fsl-quadspi: spi-rx/tx-bus-width usage
 example
In-Reply-To: <1517333637-17331-3-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1517333637-17331-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <1517333637-17331-3-git-send-email-yogeshnarayan.gaur@nxp.com>
Message-ID: <CAL_JsqLBUDNEWkcrNcrOmuYcR=Gbf2ALD=z4s9AP4poOcBxNRQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 30, 2018 at 11:33 AM, Yogesh Gaur
<yogeshnarayan.gaur@nxp.com> wrote:
> Added usage example by adding support for spi-rx-bus-width
> and spi-tx-bus-width binding.

Why not just add to existing example? Is there something unclear about
adding these properties to warrant an example? We don't need every
possible option enumerated.

Rob
