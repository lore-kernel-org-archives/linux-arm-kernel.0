From: saeed.bishara@gmail.com (saeed bishara)
Date: Wed, 9 Mar 2011 16:16:41 +0200
Subject: [PATCH] stable: sheevaplug-setup.c fix LED color name and add
	support for second LED This is a patch to the sheevaplug-setup.c file
	that
	fixes the color name of the existing health LED. That LED gpio 49 is
	green when off and blue when on. The pat
Message-ID: <AANLkTinydE-N2eVgq5aF4m31Asd8sWO2sNgO5tjcGDU6@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 9, 2011 at 3:27 PM, Robin Becker <replabrobin@gmail.com> wrote:
> From: replabrobin <robin@reportlab.com>
please use short subject for this commit, and move the description
into the commit description section
aslo, I would split this to two patches, one fixes the LED color name,
the second for adding the new LED.

> ?static unsigned int sheevaplug_mpp_config[] __initdata = {
> ? ? ? ?MPP29_GPIO, ? ? /* USB Power Enable */
> - ? ? ? MPP49_GPIO, ? ? /* LED */
> + ? ? ? MPP46_GPIO, ? ? /* RED LED */
> + ? ? ? MPP49_GPIO, ? ? /* BLUE LED */
> ? ? ? ?0
> ?};
>
> ?static unsigned int sheeva_esata_mpp_config[] __initdata = {
> ? ? ? ?MPP29_GPIO, ? ? /* USB Power Enable */
> ? ? ? ?MPP44_GPIO, ? ? /* SD Write Protect */
> + ? ? ? MPP46_GPIO, ? ? /* RED LED */
> ? ? ? ?MPP47_GPIO, ? ? /* SD Card Detect */
> ? ? ? ?MPP49_GPIO, ? ? /* LED Green */
please fix the comment as well
