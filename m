From: olof@lixom.net (Olof Johansson)
Date: Fri, 3 Apr 2015 12:51:42 -0700
Subject: [PATCH v2] coresight: adding basic support for Spreadtrum SC9836
In-Reply-To: <1427287931-9363-1-git-send-email-zhang.chunyan@linaro.org>
References: <1427287931-9363-1-git-send-email-zhang.chunyan@linaro.org>
Message-ID: <20150403195142.GR23023@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 25, 2015 at 08:52:11PM +0800, Chunyan Zhang wrote:
> Support only for ETF, FUNNEL, STM are included currently.
> Support for ETM, TPIU and the replicator linked to it are not included in
> this version patch.
> 
> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
> ---
> Change for v2:
>  - Corrected the TMC whose space is wrongly used as ETB in v1.
>  - Removed "coresight-default-sink" from the DT.
> ---

Appled but with subject:

arm64: dts: sprd: adding coresight entries to Spreadtrum SC9836                 



-Olof
