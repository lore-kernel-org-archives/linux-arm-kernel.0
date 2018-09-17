From: robh@kernel.org (Rob Herring)
Date: Mon, 17 Sep 2018 01:45:11 -0400
Subject: [PATCH 1/6] dt-bindings: ramoops: Add event-size property
In-Reply-To: <4ec22906649fb3f6ab9570d8d4bf214e61512664.1536430404.git.saiprakash.ranjan@codeaurora.org>
References: <cover.1536430404.git.saiprakash.ranjan@codeaurora.org>
 <4ec22906649fb3f6ab9570d8d4bf214e61512664.1536430404.git.saiprakash.ranjan@codeaurora.org>
Message-ID: <5b9f3f67.1c69fb81.3125b.c205@mx.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun,  9 Sep 2018 01:57:02 +0530, Sai Prakash Ranjan wrote:
> Add an optional property called event-size to reserve
> log buffer for trace events.
> 
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> ---
>  .../devicetree/bindings/reserved-memory/ramoops.txt        | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
