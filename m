From: rnayak@ti.com (Rajendra Nayak)
Date: Fri, 7 Jan 2011 14:07:25 +0530
Subject: [PATCH] OMAP: powerdomain: remove unused func declaration
Message-ID: <mailman.108.1294389661.1530.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Trivial fix to remove the unused function declaration
from the powerdomain header.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/powerdomain.h |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomain.h
b/arch/arm/mach-omap2/powerdomain.h
index c66431e..0b7a357 100644
--- a/arch/arm/mach-omap2/powerdomain.h
+++ b/arch/arm/mach-omap2/powerdomain.h
@@ -165,7 +165,6 @@ struct pwrdm_ops {
 	int	(*pwrdm_wait_transition)(struct powerdomain *pwrdm);
 };

-void pwrdm_fw_init(void);
 void pwrdm_init(struct powerdomain **pwrdm_list, struct pwrdm_ops
*custom_funcs);

 struct powerdomain *pwrdm_lookup(const char *name);
-- 
1.7.0.4

>
> I currently have a 'fixes-for-tony' branch in my tree which has all the
> fixes I've collected for the -rc cycle.
>
> If you prefer something separate with only the prm and clockdomain
> patches from this series, I can do that as well.
>
> Kevin
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--001517478c1086211304993d93fe
Content-Type: application/octet-stream; 
	name="0001-OMAP-powerdomain-remove-unused-func-declaration.patch"
Content-Disposition: attachment; 
	filename="0001-OMAP-powerdomain-remove-unused-func-declaration.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: 98bf8ae8cb917994_0.1

RnJvbSBiYjQ2Yjc0ZDJiMGFiM2QzNWU3MmI3NjBkYTdlMTIzYTg5MWU2ODEzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSYWplbmRyYSBOYXlhayA8cm5heWFrQHRpLmNvbT4KRGF0ZTog
RnJpLCA3IEphbiAyMDExIDE0OjA3OjI1ICswNTMwClN1YmplY3Q6IFtQQVRDSF0gT01BUDogcG93
ZXJkb21haW46IHJlbW92ZSB1bnVzZWQgZnVuYyBkZWNsYXJhdGlvbgoKVHJpdmlhbCBmaXggdG8g
cmVtb3ZlIHRoZSB1bnVzZWQgZnVuY3Rpb24gZGVjbGFyYXRpb24KZnJvbSB0aGUgcG93ZXJkb21h
aW4gaGVhZGVyLgoKU2lnbmVkLW9mZi1ieTogUmFqZW5kcmEgTmF5YWsgPHJuYXlha0B0aS5jb20+
Ci0tLQogYXJjaC9hcm0vbWFjaC1vbWFwMi9wb3dlcmRvbWFpbi5oIHwgICAgMSAtCiAxIGZpbGVz
IGNoYW5nZWQsIDAgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9h
cmNoL2FybS9tYWNoLW9tYXAyL3Bvd2VyZG9tYWluLmggYi9hcmNoL2FybS9tYWNoLW9tYXAyL3Bv
d2VyZG9tYWluLmgKaW5kZXggYzY2NDMxZS4uMGI3YTM1NyAxMDA2NDQKLS0tIGEvYXJjaC9hcm0v
bWFjaC1vbWFwMi9wb3dlcmRvbWFpbi5oCisrKyBiL2FyY2gvYXJtL21hY2gtb21hcDIvcG93ZXJk
b21haW4uaApAQCAtMTY1LDcgKzE2NSw2IEBAIHN0cnVjdCBwd3JkbV9vcHMgewogCWludAkoKnB3
cmRtX3dhaXRfdHJhbnNpdGlvbikoc3RydWN0IHBvd2VyZG9tYWluICpwd3JkbSk7CiB9OwogCi12
b2lkIHB3cmRtX2Z3X2luaXQodm9pZCk7CiB2b2lkIHB3cmRtX2luaXQoc3RydWN0IHBvd2VyZG9t
YWluICoqcHdyZG1fbGlzdCwgc3RydWN0IHB3cmRtX29wcyAqY3VzdG9tX2Z1bmNzKTsKIAogc3Ry
dWN0IHBvd2VyZG9tYWluICpwd3JkbV9sb29rdXAoY29uc3QgY2hhciAqbmFtZSk7Ci0tIAoxLjcu
MC40Cgo=
--001517478c1086211304993d93fe--
