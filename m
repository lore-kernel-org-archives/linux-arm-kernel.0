From: jic23@kernel.org (Jonathan Cameron)
Date: Sat, 1 Jul 2017 10:18:53 +0100
Subject: [PATCH v2 1/3] dt-bindings: adc: mt7622: add binding document
In-Reply-To: <20170628164622.4fmqmlhhyvkwvbwd@rob-hp-laptop>
References: <1498457502-3669-1-git-send-email-zhiyong.tao@mediatek.com>
 <1498457502-3669-2-git-send-email-zhiyong.tao@mediatek.com>
 <20170628164622.4fmqmlhhyvkwvbwd@rob-hp-laptop>
Message-ID: <20170701101853.329e3291@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 28 Jun 2017 11:46:22 -0500
Rob Herring <robh@kernel.org> wrote:

> On Mon, Jun 26, 2017 at 02:11:40PM +0800, Zhiyong Tao wrote:
> > The commit adds mt7622 compatible node in binding document.
> > 
> > Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
> > ---
> >  .../devicetree/bindings/iio/adc/mt6577_auxadc.txt  |    1 +
> >  1 file changed, 1 insertion(+)  
> 
> Acked-by: Rob Herring <robh@kernel.org>

Applied to the togreg branch of iio.git and pushed out
as testing for the autobuilders to play with it.

Thanks,

Jonathan
