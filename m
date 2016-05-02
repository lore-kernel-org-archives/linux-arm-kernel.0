From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 2 May 2016 13:15:22 -0300
Subject: [PATCH v2 2/2] nvmem: mxs-ocotp: remove nvmem regmap dependency
In-Reply-To: <1462202578-15433-3-git-send-email-srinivas.kandagatla@linaro.org>
References: <1462202578-15433-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1462202578-15433-3-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <CAOMZO5DoqdOPM+i6D37PviCbiDSc3OV2rz8vGRi0mqV4uBvgaw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 2, 2016 at 12:22 PM, Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
> This patch moves to nvmem support in the driver to use callback
> instead of regmap.

It would be nice if you could explain the reason for doing this.
