From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed, 30 Nov 2016 17:00:59 +0100
Subject: [PATCH v2 3/4] dt-bindings: display: add Amlogic Meson DRM
 Bindings
In-Reply-To: <2734274.BAOZxRirYz@avalon>
References: <1480520625-13269-1-git-send-email-narmstrong@baylibre.com>
 <1480520625-13269-4-git-send-email-narmstrong@baylibre.com>
 <2734274.BAOZxRirYz@avalon>
Message-ID: <2e1b16c6-eec5-8cf3-5795-d6de02f36570@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent,
On 11/30/2016 04:58 PM, Laurent Pinchart wrote:
> Hi Neil,
> 
> On Wednesday 30 Nov 2016 16:43:44 Neil Armstrong wrote:
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>  .../bindings/display/meson/meson-drm.txt           | 101 ++++++++++++++++++
> 
> I forgot to mention that the file should not be named meson-drm.txt as DRM is 
> a Linux-specific concept. You can name it meson.txt, but a better option would 
> be amlogic,meson.txt. By the way does it really need a subdirectory ?

I took example of the sun4i layout the naming, and no it does not need a subdirector..

I will move it to amlogic,meson.txt, seems far better.

Thanks,
Neil

>>  1 file changed, 101 insertions(+)
>>  create mode 100644
>> Documentation/devicetree/bindings/display/meson/meson-drm.txt
> 
