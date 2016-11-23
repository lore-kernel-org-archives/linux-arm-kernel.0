From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 23 Nov 2016 11:25:42 +0530
Subject: [PATCH v2 1/5] ARM: memory: da8xx-ddrctl: new driver
In-Reply-To: <58348CB8.7050304@gmail.com>
References: <1477925138-23457-1-git-send-email-bgolaszewski@baylibre.com>
 <1477925138-23457-2-git-send-email-bgolaszewski@baylibre.com>
 <a309a738-7fa7-3aab-4457-f7d693e6b37f@ti.com> <5833A2DA.40701@gmail.com>
 <800171a8-2e2c-2afb-f96d-800a17eaa17a@ti.com> <58348CB8.7050304@gmail.com>
Message-ID: <b668871c-2b54-0a2f-0d68-afaa50e17e63@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 22 November 2016 11:51 PM, Frank Rowand wrote:
> Please note that the compatible property might contain several strings, not just
> a single string.

So I guess the best thing to do is to use
of_property_read_string_index() and print the sting at index 0.

Thanks,
Sekhar
