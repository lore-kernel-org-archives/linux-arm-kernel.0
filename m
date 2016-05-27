From: robh@kernel.org (Rob Herring)
Date: Fri, 27 May 2016 10:47:03 -0500
Subject: [PATCH v4 10/18] ASoC: sti: Update DT example to match the
 driver code
In-Reply-To: <1464192412-16386-12-git-send-email-peter.griffin@linaro.org>
References: <1464192412-16386-1-git-send-email-peter.griffin@linaro.org>
 <1464192412-16386-12-git-send-email-peter.griffin@linaro.org>
Message-ID: <20160527154703.GA21568@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 25, 2016 at 05:06:44PM +0100, Peter Griffin wrote:
> uniperiph-id, version and mode are ST specific bindings and
> need the 'st,' prefix. Update the examples, as otherwise copying
> them yields a runtime error parsing the DT node.
> 
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> Cc: arnaud.pouliquen at st.com
> Cc: broonie at kernel.org
> ---
>  .../devicetree/bindings/sound/st,sti-asoc-card.txt   | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
