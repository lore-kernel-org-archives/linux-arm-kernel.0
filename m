From: embed3d@gmail.com (Philipp Rossak)
Date: Thu, 30 Aug 2018 17:44:59 +0200
Subject: [PATCH v3 11/30] iio: adc: add new compatibles
In-Reply-To: <20180830154518.29507-1-embed3d@gmail.com>
References: <20180830154518.29507-1-embed3d@gmail.com>
Message-ID: <20180830154518.29507-12-embed3d@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We are now adding the new compatibles.

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
---
 drivers/iio/adc/sun4i-gpadc-iio.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
index a2027614ee0c..79b8efdab803 100644
--- a/drivers/iio/adc/sun4i-gpadc-iio.c
+++ b/drivers/iio/adc/sun4i-gpadc-iio.c
@@ -435,6 +435,18 @@ static const struct of_device_id sun4i_gpadc_of_id[] = {
 		.compatible = "allwinner,sun8i-a33-ths",
 		.data = &sun8i_a33_gpadc_data,
 	},
+	{
+		.compatible = "allwinner,sun4i-a10-gpadc",
+		.data = &sun4i_gpadc_data
+	},
+	{
+		.compatible = "allwinner,sun5i-a13-gpadc",
+		.data = &sun5i_gpadc_data
+	},
+	{
+		.compatible = "allwinner,sun6i-a31-gpadc",
+		.data = &sun6i_gpadc_data
+	},
 	{ /* sentinel */ }
 };
 
-- 
2.11.0
