From: festevam@gmail.com (Fabio Estevam)
Date: Fri,  9 Jun 2017 08:56:05 -0300
Subject: [PATCH] imx: Add SDMA firmware for Freescale i.MX6/7 SoCs.
Message-ID: <1497009365-14539-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nitin Garg <nitin.garg@nxp.com>

Add the firmwares for the i.MX SDMA driver that runs on i.MX6
and i.MX7.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
Signed-off-by: Nitin Garg <nitin.garg@nxp.com>
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 LICENSE.sdma_firmware   |   47 +++++++++++++++++++++++++++++++++++++++++++++++
 WHENCE                  |   11 +++++++++++
 imx/sdma/sdma-imx6q.bin |  Bin 0 -> 2196 bytes
 imx/sdma/sdma-imx7d.bin |  Bin 0 -> 2302 bytes
 4 files changed, 58 insertions(+)
 create mode 100644 LICENSE.sdma_firmware
 create mode 100644 imx/sdma/sdma-imx6q.bin
 create mode 100644 imx/sdma/sdma-imx7d.bin

diff --git a/LICENSE.sdma_firmware b/LICENSE.sdma_firmware
new file mode 100644
index 0000000..0d3d562
--- /dev/null
+++ b/LICENSE.sdma_firmware
@@ -0,0 +1,47 @@
+Copyright 2017, NXP
+All rights reserved.
+
+Redistribution. Reproduction and redistribution in binary form, without
+modification, for use solely in conjunction with a NXP
+chipset, is permitted provided that the following conditions are met:
+
+  . Redistributions must reproduce the above copyright notice and the following
+    disclaimer in the documentation and/or other materials provided with the
+    distribution.
+
+  . Neither the name of NXP nor the names of its suppliers
+    may be used to endorse or promote products derived from this Software
+    without specific prior written permission.
+
+  . No reverse engineering, decompilation, or disassembly of this Software is
+    permitted.
+
+Limited patent license. NXP (.Licensor.) grants you
+(.Licensee.) a limited, worldwide, royalty-free, non-exclusive license under
+the Patents to make, have made, use, import, offer to sell and sell the
+Software. No hardware per se is licensed hereunder.
+The term .Patents. as used in this agreement means only those patents or patent
+applications owned solely and exclusively by Licensor as of the date of
+Licensor.s submission of the Software and any patents deriving priority (i.e.,
+having a first effective filing date) therefrom. The term .Software. as used in
+this agreement means the firmware image submitted by Licensor, under the terms
+of this license, to git://git.kernel.org/pub/scm/linux/kernel/git/firmware/
+linux-firmware.git.
+Notwithstanding anything to the contrary herein, Licensor does not grant and
+Licensee does not receive, by virtue of this agreement or the Licensor's
+submission of any Software, any license or other rights under any patent or
+patent application owned by any affiliate of Licensor or any other entity
+(other than Licensor), whether expressly, impliedly, by virtue of estoppel or
+exhaustion, or otherwise.
+
+DISCLAIMER. THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
+CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING,
+BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
+FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL
+THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
+INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
+BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS
+OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR
+TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
+USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
diff --git a/WHENCE b/WHENCE
index 2d17e2e..c3a8dc1 100644
--- a/WHENCE
+++ b/WHENCE
@@ -3586,3 +3586,14 @@ File: wil6210.brd
 Version: 4.1.0.55
 
 Licence: Redistributable. See LICENSE.QualcommAtheros_ath10k for details
+
+--------------------------------------------------------------------------
+
+Driver: imx-sdma - support for i.MX SDMA driver
+
+File: imx/sdma/sdma-imx6q.bin 
+Version: 3.3
+File: imx/sdma/sdma-imx7d.bin
+Version: 4.2
+
+Licence: Redistributable. See LICENSE.sdma_firmware for details
diff --git a/imx/sdma/sdma-imx6q.bin b/imx/sdma/sdma-imx6q.bin
new file mode 100644
index 0000000000000000000000000000000000000000..f0b5252a6fc5f85aced28a5c43e7268340fe4d73
GIT binary patch
literal 2196
zcmb7_U2GIp6oAj%ou8fA*8b77mX_9vODX>XQ3(MNVlZLROuNt)x70BW?a*%fX3 at Db
z!DuX2+h}>1-A%QLCYTtWG{F!O`jf~IF-q1}aV1FBhhm|U)CXlB)^lff+a-ZSx;ZoF
zoVoYhZ_b%>+O#jQ#{&RNs!`UWOrZQE0lZBB(*N`Cg{sWjdEE1LWk&xb>zlyf`C-1y
z#(gW#e}D%FqvWs4>45Q$pe#HN5LgK?hjHJ*JM$+e6NeX7PEV<El<KN!eNHPO=^dNB
zKa$<X2<(O#;OK`iF3g7pcn>|nSJOJ<1Yd3}9O@7SDtB%*6>W>T)>gEQrrf#SEEP(H
zv&7NYSe`oAf5+HklL1+C^ylqzAOlKPW4aIZ6~>L;Qp=KLno at Z@J+3<%-{`nJ0P{fz
zNc0{uinat-x(d3=rj#kpzBb9YlSh-t{)9e~$Cx^lp=_jEkh0F`_mz0&o1mz}!&sj|
z*6pT+tWP8B<}7Q6M5x&Ip6zd2V{x^Ndd}Tf*7OB3^GGkY$(q0I3|h=q&{mdg=JBD&
zhaSnuFpJ2XJggyehWMz>ILexOB+j at tnQDJuJnm|X?TOZS%LrG at 6+JfuJ15uCi8klR
z!O1nopy!mBd^KHIBBX0B2)iT*RMLKL37D8Eio6Z#4f`K8(R_hiA+lk(o;mcyGad^3
ztUUx1s?*duIZJ_jYp1;z!IH}9AirGE5mJi3^p0NzV(gO2BA=7%gixlnqp<7~!^X-l
zs;OpOdX^$T)gs3wYII9H?ZQ*J#~LG}EwlKI48v$}To?_Fi at lOa!;+7Z0TSdxyCW<^
zOsl`oBEi+68Uqe`F_wptV1 at Zogb%H-PKl$hz<!R_M`m!R=<a-3Vyib{&SoMN(1&-f
zZZtRs68v^;!Cq$Re*lYwEQK`Q!)Tn|L5vyiVLVQ6ebyERe(qs5lcGE#+59--^omPF
zT}bppWcjo+4?S&KCj(9=AG(OA2?LjOrswQwop+x(ovTC3r#YRnc^Th-`Ls{*w9GrE
zd)QlIuQs!aaK?f?YcoBqV5e4D5;4YwTahvNKsYaq3&rF-f0l3NMaXo?qAKKdNUlHD
z(pv0~jYcxmkKfpxAa)4r0#%9n)vacSKxi?38M3~?V%J9Zn(K}~jbw0pl=T9utf=~Q
zKgu@O!)yg@#kH9wqb2LI(V$BfK;ke21h=CXBX3MK^UBoSNM;5Jdg{<HIgK;G(YlGB
zo?bN_j)xtM!?$$w(|#LmN3;FY;SN$nGgc4rQ06%qEyh*2T4&ZrQAg{I%6g^6Jq3YU
z8jL2xBk+sB=9r_&dI9>mx_bs=DW(lNk6diVycm^$*9!FEXoG&w;<Y!YS}>1k?7DR2
z1^6B~<0L-0<33TQ_C}ZUn;|D^H>p8xQQc3(HbyL}2T-$Jt%E3r?HAQBd6LR{jmx&0
zeuWV$+=zcfbByBxTUCs!6pO3-7c(a!Ap{EDynU9Xym=pGgZ{UrOpQm^C)hj}^h at 2#
zQ!zKU%dz6CaBe$VgV`bGDqQc at w${B?yEFSQV`Yrh7QbQ5r&poQGzB$wU#cZe=D5mv
zNel3|qpX%0i{tktZbdWmE^$<m;w?jvYTr3oo}FzaINR=qa+3`LJlz}fN^Ip2Osn7F
zyt<9^YFms8`(E2*`m_zE@AY+NL16{Yeq+41=8C`>1%+32D0)G1`mXm?Tf;C0T$k at y
zg*kJa_abFqsZ?V4jun|XOEIqZd9AD6ToK#hu{aL+)|doo{GS4(HFi0hx0HG*uUj5H
ibKm4;?%Y!5&OJ19gR%U~-Aue2dz8%m{(#I~jr|8{yblQg

literal 0
HcmV?d00001

diff --git a/imx/sdma/sdma-imx7d.bin b/imx/sdma/sdma-imx7d.bin
new file mode 100644
index 0000000000000000000000000000000000000000..ea847c5a90a2be81c0d77596698955f3e03203c9
GIT binary patch
literal 2302
zcmb7FeQXp}5TAXwAGdo~`$f|VEv<YUN0BdyArb;&Odx10+4g8DURzfy?NZwQ*_wU3
zi7^qZ(m#rE?~W#oF=9-RXb6dfM0z!{i5MXl8sQ{pE-Dd=#`=f$NX~h?y<UkWk-NOz
znc3NSzx~a;nWkqOcJTl}a8=`~$Mq$yZGM0^(3tz5KmStCcN*V0Tjj~G%-NE@`{SIR
zi%S>S8xh0+uEn+kjCT;%*+&7&mjQf&arfe#*_r=O6X}*2mD96o3Rm^gN&U7~N^;va
z`LB?j#t7_$YrxTWU|hHp9prs<h_9w~#t>g&+}+<P3RLdeVk+8ZbFHmt8%(+DakES)
z6HXIHUt{^|V9&I%%O-=e=IBq`6+i}+If=;ul$RK{j+9xJB-5<Q<L)Wl(fE4D#RG6B
z0u2(qhZsd$g3H~(?uukE$=TN@8176*2C+Y;k1W8L-S45Sr<)OFoiPw7_1$TL;!YpK
zx)rfLX<CT&3B<Z-4r`}G46*G^JJhzu;%XV{+wObiO&=j<9?^?!vKDGPg&NZp)RlRi
zSpsMYphYq~%pzjWv}lOgL)>9A9OX^D5@%eW$hN;F9(JXf_Vj^N>j+oE6+bl$+b7o1
zi*3%q#)&n?QQt8!^J1>3RLIp_5Ozq=P(=s)rC=gcR3bF2-m?Ez)6EyiWg;7fYq^b<
zlxLy9Puat8QFWRQOiWQAU)eeT7hp*h^eA7*=m;spe{S0iffzfa^4JIDCLxqb?YJ2G
z#IP~*GitV3mqHZr(|xhSQj5_e at w6Lv<sPYzjkZo<jU0#3$ha^X9T&+UiSW@H0~-D4
z=c6Q2X>N`2(IwU~adaQ-;pmE3B31#S>-U00BCDbsk&i^I68iDZ)s05RK!W$L-?dY{
zg`GMU-N`vpykIBU?2S1`#QB|CaHn@;lX at Y_>x)Ejy7*`ziqj>VBZ#*U<u#1rVaoL~
zQ~;S~#tvuPwWn+*=M+3OOD(LVap6pC4Bi&b3*$lwInSTwn|Tquik(q~1=X6b)wQ%1
zYjuN>i4I`Crz2Rc$gHSdiG|cHW~V at C31&&w*IVpb?_Tqj`m2$NWRXj+GDS6 at hj7ih
z7Jg7v71R}1XPS(ftjk7Nmn?vE3p5Ds>H0i2lx*gM$#XHU9|(GO|8a5x&!eODkPtnw
ze6laq=V%;$rK6t+*{D039h&UxB*oOzdWnxR%kFpydZD+ at w3fJ|ZHdczmBp=whFZET
zp6MHb?*!IU98K1PXy at u?4ThzJhIJlsvGX2`OTcSEy*VD%XDwbclC8*N4o^U?>H>TN
zoUt39OuJ8lNjYBN*F#R!9#Vt2MRgAm+ZbX|eI6y-l{$%H*dbBvBP*$_*SOeL(IJdj
z=|=oGp2s*YFs~ByQY^0SA7oBMgwRmr^42ql^3;7O!}?!VF!^fy&l{|_3i_p<LWj!t
z&<f1>a_pgw7B)M at e1=!Jxvh1t)o%a%-S{!ia!UpsEujB^GLsaP*nK{i*d<dc=O?Ye
ze->xC^fZoF(r4mc?@4zkQmS<rvhCX^D(3o3DfXE^qWLZZ4Lp?-eu;Sw!=(B(_Kx4M
zcg)7QzQ9Wx&49Mv47|L~3>H=L>_5i)Yc30%5iGi at L-8|`(|@zS+Byznz;y=>Rhrih
z^L|9xUnZ3rfkVY+UQ>*l{eJ6e4_D0I at L3!Od~HI49QJo0wTY3m$6HptwBWQnJacBE
zz#K){V~!>s#9U)yA#<nF&m|s)xepg%?!Cl4_glRATBw2t&C+_DPhs=hgrcp+`LuF=
zmM)*0rN1C{HcNkYzlP0HCgo>o0B5O;)yX=OJYNszkXdhX=4)cf_n$u0mzAIVZ%yzg
F{{=eRHj4lN

literal 0
HcmV?d00001

-- 
1.7.9.5
