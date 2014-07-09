From: riel@redhat.com (Rik van Riel)
Date: Tue, 08 Jul 2014 23:11:28 -0400
Subject: [PATCH v3 05/12] ARM: topology: use new cpu_power interface
In-Reply-To: <1404144343-18720-6-git-send-email-vincent.guittot@linaro.org>
References: <1404144343-18720-1-git-send-email-vincent.guittot@linaro.org>
 <1404144343-18720-6-git-send-email-vincent.guittot@linaro.org>
Message-ID: <53BCB2E0.5000401@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 06/30/2014 12:05 PM, Vincent Guittot wrote:
> Use the new arch_scale_cpu_power in order to reflect the original
> capacity of a CPU instead of arch_scale_freq_power which is more
> linked to a scaling of the capacity linked to the frequency.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

Acked-by: Rik van Riel <riel@redhat.com>


- -- 
All rights reversed
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJTvLLgAAoJEM553pKExN6DZ40H/38CjOJQjRY4WZ+2UxlXSXfU
V7gcMwHCNIJvJQ0fG3IfxVacdlJsK8LsQMgPL5sYCeJpLKYrQHPIQ2dIdkmz2W9I
lcpr5dBq1AAB+PAbkywV2wtQBlDd0AMMQNrPqL6FdK92M4ML3iweJluA4qp0K1ip
AtZM90ku4SQ52RyQR3ePIb396CeT1TRqihDnpWxbcZt53DkqWW3SCVE68qL1SIEO
YKKlZyFXxLJDBZfM2kk90L8NPSmXzTa9xdsu+3CQKiyukqhgJoNe6J9E11CjlKBx
BQggFRRTliIUat7IGlkgcyWLhXhhMLrfoXJN/sEdrWG2T2rApnI4u2Q4PM02/zU=
=hHGQ
-----END PGP SIGNATURE-----
