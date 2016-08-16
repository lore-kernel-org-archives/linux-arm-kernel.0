From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 16 Aug 2016 10:45:43 +0800
Subject: [PATCH 3/8] ARM: dts: sun8i: reference-design-tablet: Add gsl1680
 touchscreen node
In-Reply-To: <1470685398-14568-3-git-send-email-hdegoede@redhat.com>
References: <1470685398-14568-1-git-send-email-hdegoede@redhat.com>
 <1470685398-14568-3-git-send-email-hdegoede@redhat.com>
Message-ID: <CAGb2v67jkZGAosSjO3vSaf0sTWvqVjmQXPB5LRR4Ah0_0-RM6w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 9, 2016 at 3:43 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> Almost all sun8i tablets use a gsl1680 touchscreen controller, so add
> a node describing it to reference-design-tablet.dtsi.
>
> Almost all, but not all, so mark it as disabled by default (dts files
> will also need to supply a firmware-name and resolution info).
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
