From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 16 Feb 2017 22:51:47 -0200
Subject: [PATCH v4 07/36] ARM: dts: imx6-sabresd: add OV5642 and OV5640
 camera sensors
In-Reply-To: <1487211578-11360-8-git-send-email-steve_longerbeam@mentor.com>
References: <1487211578-11360-1-git-send-email-steve_longerbeam@mentor.com>
 <1487211578-11360-8-git-send-email-steve_longerbeam@mentor.com>
Message-ID: <CAOMZO5AHJ2jSWvF1iZKhYyDAMmpg99R4-gz4ZyDZAcB4b3d0ag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Steve,

On Thu, Feb 16, 2017 at 12:19 AM, Steve Longerbeam
<slongerbeam@gmail.com> wrote:
> Enables the OV5642 parallel-bus sensor, and the OV5640 MIPI CSI-2 sensor.
>
> The OV5642 connects to the parallel-bus mux input port on ipu1_csi0_mux.
>
> The OV5640 connects to the input port on the MIPI CSI-2 receiver on
> mipi_csi.
>
> Until the OV5652 sensor module compatible with the SabreSD becomes
> available for testing, the ov5642 node is currently disabled.

You missed your Signed-off-by.
