From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 30 May 2016 13:49:09 -0300
Subject: [PATCH 2/5] arm/dts/imx6q-b850v3: Configure IPU assignment order
In-Reply-To: <1464626385-19253-3-git-send-email-peter.senna@collabora.com>
References: <1464626385-19253-1-git-send-email-peter.senna@collabora.com>
 <1464626385-19253-3-git-send-email-peter.senna@collabora.com>
Message-ID: <CAOMZO5Cek0nNXPCQxE-gXQqX83MAyPy56nmktETDxX3Ls2XZMA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 30, 2016 at 1:39 PM, Peter Senna Tschudin
<peter.senna@collabora.com> wrote:
> Configure the IPU assignment order to assign one IPU per external
> display. A single IPU can drive multiple external displays but there are
> resolution restrictions. After this patch the GPU is capalbe of driving two

I think you meant "the IPU is capable"
