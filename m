From: frowand.list@gmail.com (Frank Rowand)
Date: Fri, 14 Sep 2018 14:32:43 -0700
Subject: [PATCH 3/3] scripts/dtc: Update to upstream version
 v1.4.7-14-gc86da84d30e4
In-Reply-To: <20180913202828.15372-3-robh@kernel.org>
References: <20180913202828.15372-1-robh@kernel.org>
 <20180913202828.15372-3-robh@kernel.org>
Message-ID: <f9684222-fae0-c305-d48a-be77ebb985a3@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/13/18 13:28, Rob Herring wrote:
> Major changes are I2C and SPI bus checks, YAML output format (for
> future validation), some new libfdt functions, and more libfdt
> validation of dtbs.
> 
> The YAML addition adds an optional dependency on libyaml. pkg-config is
> used to test for it and pkg-config became a kconfig dependency in 4.18.

For Ubuntu, the libyaml dependency is provided by the packages:

   libyaml-0-2
   libyaml-dev


-Frank

> 
> This adds the following commits from upstream:
> 
> c86da84d30e4 Add support for YAML encoded output
> 361b5e7d8067 Make type_marker_length helper public


< snip >
