From: joe@perches.com (Joe Perches)
Date: Mon, 22 Jun 2015 21:52:53 -0700
Subject: [PATCH v6 1/9] nvmem: Add a simple NVMEM framework for nvmem
 providers
In-Reply-To: <1435014507-26181-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1435014459-26138-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1435014507-26181-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1435035173.9808.35.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2015-06-23 at 00:08 +0100, Srinivas Kandagatla wrote:
> This patch adds just providers part of the framework just to enable easy
> review.
[]
>  include/linux/nvmem-provider.h |  54 ++++++

Unless there are going to be users of nvmem-provider.h
outside of the drivers/nvmem directory, perhaps that
file (and nvmem-consumer.h) should be in drivers/nvmem/
